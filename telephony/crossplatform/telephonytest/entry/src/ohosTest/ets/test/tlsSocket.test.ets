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

import { describe, it, Level, Size, TestType } from '@ohos/hypium';
import socket from '@ohos.net.socket';
import { BusinessError } from '@ohos.base';
import {
  expectFail,
  expectTrue,
} from './utils';

let addr: socket.NetAddress = {
  address: '127.0.0.1',
  port: 0,
  family: 1
};

export default function TLSSocketTest() {
  describe('TLSSocketTest', () => {

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0100
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0100
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0100';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
            console.info(`${caseName} test end`);
            done();
            tlsSocket.close();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          console.info(`${caseName} test end`);
          expectFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0200
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0200
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0200';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: 'www.baidu.com',
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0300
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0300
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0300';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0400
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0400
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0400';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: -1,
            family: 1
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0500
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0500
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0500';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 6565656,
            family: 1
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0600
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0600
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0600';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 0,
            family: 3
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0700
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0700
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0700';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          tlsSocket.bind(addr, (err: BusinessError) => {
            if (err) {
              console.info(`${caseName} err: ${JSON.stringify(err)}`);
              expectFail();
            } else {
              expectTrue(true);
            }
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0800
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0800
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0800';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_0900
     * @tc.name   : testNetworkMgrSocketTLSSocketBind0900
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind0900';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
          };
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_1000
     * @tc.name   : testNetworkMgrSocketTLSSocketBind1000
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind1000';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: -1,
            family: 1
          };
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_1100
     * @tc.name   : testNetworkMgrSocketTLSSocketBind1100
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind1100';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 6565656,
            family: 1
          };
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_1200
     * @tc.name   : testNetworkMgrSocketTLSSocketBind1200
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind1200';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '127.0.0.1',
            port: 0,
            family: 3
          };
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
     * @tc.number : SUB_NETWORKMGR_SOCKET_TLSSOCKET_BIND_1300
     * @tc.name   : testNetworkMgrSocketTLSSocketBind1300
     * @tc.desc   : Bind IP address and port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testNetworkMgrSocketTLSSocketBind1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTLSSocketBind1300';
        console.info(`${caseName} test start`);
        try {
          let tlsSocket: socket.TLSSocket = socket.constructTLSSocketInstance();
          let addr: socket.NetAddress = {
            address: '::1',
            port: 0,
            family: 2
          };
          tlsSocket.bind(addr).then(() => {
            expectTrue(true);
            console.info(`${caseName} test end`);
            done();
          }).catch((err: BusinessError) => {
            console.info(`${caseName} err: ${JSON.stringify(err)}`);
            expectFail();
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
  });
}