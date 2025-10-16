/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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

import { describe, it, Level, Size, TestType } from '@ohos/hypium';
import socket from '@ohos.net.socket';
import { BusinessError, Callback } from '@ohos.base';
import {
  expectFail,
  expectEqual,
  expectTrue,
  SocketInfo,
  ArrayBufferToString,
} from './utils';

let UDPAddr1: socket.NetAddress = {
  address: '127.0.0.1',
  port: 0,
  family: 1
};

let UDPAddr2: socket.NetAddress = {
  address: '127.0.0.1',
  port: 8080,
  family: 1
};

export default function UDPSocketTest() {
  describe('UDPSocketTest', () => {

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_CONSTRUCTUDPSOCKETINSTANCE_0100
     * @tc.name   : testNetworkMgrSocketUDPSocketConstructUDPSocketInstance0100
     * @tc.desc   : Create a UDPSocket object
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testNetworkMgrSocketUDPSocketConstructUDPSocketInstance0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketConstructUDPSocketInstance0100';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          console.info(`${caseName} ${JSON.stringify(udp)}`);
          expectTrue(udp != null);
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0100
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0100
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0100';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(UDPAddr1, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            }
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0200
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0200
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0200';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '4564646',
            port: 0,
            family: 1
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectEqual(err.code, 2301099);
            } else {
              expectFail();
            }
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0300
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0300
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0300';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0400
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0400
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0400';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: -1,
            family: 1
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0500
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0500
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0500';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 6565656,
            family: 1
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0600
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0600
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0600';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0700
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0700
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0700';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          udp.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0800
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0800
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind2100';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: 'www.baidu.com',
            port: 0,
            family: 2
          };
          udp.bind(addr).then(() => {
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectEqual(err.code, 401);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_0900
     * @tc.name   : testNetworkMgrSocketUDPSocketBind0900
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind0900';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(null, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectEqual(err.code, 401);
            } else {
              expectFail();
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1000
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1000
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1000';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(undefined, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectEqual(err.code, 401);
            } else {
              expectFail();
            }
            udp.close();
            console.info(`${caseName} test end`);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1100
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1100
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1100';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(UDPAddr1).then(() => {
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1200
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1200
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1200';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '4564646',
            port: 0,
            family: 1
          };
          udp.bind(addr).then(() => {
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectEqual(err.code, 2301099);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1300
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1300
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1300';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
          };
          udp.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1400
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1400
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1400';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: -1,
            family: 1
          };
          udp.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1500
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1500
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1500';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 6565656,
            family: 1
          };
          udp.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1600
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1600
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testNetworkMgrSocketUDPSocketBind1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1600';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          udp.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1700
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1700
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1700';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          udp.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1800
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1800
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1800';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 1
          };
          udp.bind(addr).then(() => {
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectEqual(err.code, 401);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_1900
     * @tc.name   : testNetworkMgrSocketUDPSocketBind1900
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind1900';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(null).then(() => {
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectEqual(err.code, 401);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_BIND_2000
     * @tc.name   : testNetworkMgrSocketUDPSocketBind2000
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketUDPSocketBind2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketBind2000';
        console.info(`${caseName} test start`);
        try {
          let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          udp.bind(undefined).then(() => {
            expectFail();
            console.info(`${caseName} test end`);
            udp.close();
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectEqual(err.code, 401);
            console.info(`${caseName} test end`);
            udp.close();
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });


    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_ON_MESSAGE_0100
     * @tc.name   : testNetworkMgrSocketUDPSocketOnMessage0100
     * @tc.desc   : Subscription to receive message events for UDPSocket connections
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOnMessage0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOnMessage0100';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          let udp2: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          await udp2.bind(UDPAddr2).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let sendOptions: socket.UDPSendOptions = {
            data: 'Hello, server!',
            address: UDPAddr2
          };
          udp2.on('message', (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} message: ${str}`);
            console.info(`${caseName} remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectEqual(str, sendOptions.data as string);
            console.info(`${caseName} test end`);
            udp1.close();
            udp2.close();
            done();
          });
          udp1.send(sendOptions);
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_OFF_MESSAGE_0100
     * @tc.name   : testNetworkMgrSocketUDPSocketOffMessage0100
     * @tc.desc   : Unsubscribe from receiving message events for UDPSocket connections
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOffMessage0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOffMessage0100';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          let udp2: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          await udp2.bind(UDPAddr2).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let sendOptions: socket.UDPSendOptions = {
            data: 'Hello, server!',
            address: UDPAddr2
          };
          let callback: Callback<socket.SocketMessageInfo> = (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} message: ${str}`);
            console.info(`${caseName} remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectFail();
            console.info(`${caseName} test end`);
            udp1.close();
            udp2.close();
            done();
          };
          udp2.on('message', callback);
          udp2.off('message', callback);
          await udp1.send(sendOptions).catch((err: BusinessError) => {
            console.info('fail to send' + err.code.toString());
          });
          expectTrue(true);
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_OFF_MESSAGE_0200
     * @tc.name   : testNetworkMgrSocketUDPSocketOffMessage0200
     * @tc.desc   : Unsubscribe from receiving message events for UDPSocket connections
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOffMessage0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOffMessage0200';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          let udp2: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          await udp2.bind(UDPAddr2).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let sendOptions: socket.UDPSendOptions = {
            data: 'Hello, server!',
            address: UDPAddr2
          };
          let callback1: Callback<socket.SocketMessageInfo> = (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} cb1 message: ${str}`);
            console.info(`${caseName} cb1 remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<socket.SocketMessageInfo> = (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} cb2 message: ${str}`);
            console.info(`${caseName} cb2 remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          udp2.on('message', callback1);
          udp2.on('message', callback2);
          udp2.off('message', callback2);
          await udp1.send(sendOptions).catch((err: BusinessError) => {
            console.info('fail to send' + err.code.toString());
          });
          expectTrue(true);
          console.info(`${caseName} test end`);
          udp1.close();
          udp2.close();
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_OFF_MESSAGE_0300
     * @tc.name   : testNetworkMgrSocketUDPSocketOffMessage0300
     * @tc.desc   : Unsubscribe from receiving message events for UDPSocket connections
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOffMessage0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOffMessage0300';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          let udp2: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          await udp2.bind(UDPAddr2).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let sendOptions: socket.UDPSendOptions = {
            data: 'Hello, server!',
            address: UDPAddr2
          };
          let callback1: Callback<socket.SocketMessageInfo> = (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} cb1 message: ${str}`);
            console.info(`${caseName} cb1 remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<socket.SocketMessageInfo> = (value: SocketInfo) => {
            let str: string = ArrayBufferToString(value.message);
            console.info(`${caseName} cb2 message: ${str}`);
            console.info(`${caseName} cb2 remoteInfo: ${JSON.stringify(value.remoteInfo)}`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          udp2.on('message', callback1);
          udp2.on('message', callback2);
          udp2.off('message');
          await udp1.send(sendOptions).catch((err: BusinessError) => {
            console.info('fail to send' + err.code.toString());
          });
          expectTrue(true);
          console.info(`${caseName} test end`);
          udp1.close();
          udp2.close();
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_ON_CLOSE_0100
     * @tc.name   : testNetworkMgrSocketUDPSocketOnClose0100
     * @tc.desc   : Subscription to UDPSocket connection closure event
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOnClose0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOnClose0100';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let callback: Callback<void> = () => {
            console.info(`${caseName} closed`);
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          };
          udp1.on('close', callback);
          udp1.close();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_OFF_CLOSE_0200
     * @tc.name   : testNetworkMgrSocketUDPSocketOffClose0200
     * @tc.desc   : Unsubscribe from the closing event of UDPSocket connection
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOffClose0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOffClose0200';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let callback1: Callback<void> = () => {
            console.info(`${caseName} cb1 closed`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<void> = () => {
            console.info(`${caseName} cb2 closed`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          udp1.on('close', callback1);
          udp1.on('close', callback2);
          udp1.off('close', callback2);
          await udp1.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          expectTrue(true);
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_UDPSOCKET_OFF_CLOSE_0300
     * @tc.name   : testNetworkMgrSocketUDPSocketOffClose0300
     * @tc.desc   : Unsubscribe from the closing event of UDPSocket connection
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testNetworkMgrSocketUDPSocketOffClose0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketUDPSocketOffClose0300';
        console.info(`${caseName} test start`);
        try {
          let udp1: socket.UDPSocket = socket.constructUDPSocketInstance();
          await udp1.bind(UDPAddr1).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let callback1: Callback<void> = () => {
            console.info(`${caseName} closed`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<void> = () => {
            console.info(`${caseName} closed`);
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          udp1.on('close', callback1);
          udp1.on('close', callback2);
          udp1.off('close');
          await udp1.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          expectTrue(true);
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });
  });
}