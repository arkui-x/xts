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

import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';
import socket from '@ohos.net.socket';
import { BusinessError } from '@ohos.base';

const ExpectFail: () => void = () => {
  try {
    expect().assertFail();
  } catch (err) {
    console.info(` exportFail failed err: ${JSON.stringify(err)}`);
  }
};

function expectTrue(exp: boolean, info: string = ''): void {
  try {
    expect(exp).assertTrue();
  } catch (err) {
    console.info(`${info} test failed`);
  }
}

export default function SocketErrorCodeTest01() {
  describe('SocketErrorCodeTest01', () => {
    /**
     * @tc.number : SUB_LOCALSOCKETSERVER_SETEXTRAOPTIONS_0100
     * @tc.name   : testLocalSocketServerSetExtraOptions0100
     * @tc.desc   : test LocalSocketServer SetExtraOptions(promise) 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketServerSetExtraOptions0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testLocalSocketServerSetExtraOptions0100';
        console.info(`${caseName}---Start`);
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          server.setExtraOptions(undefined).then(() => {
            console.log(`${caseName} set success`);
            ExpectFail();
            done();
          }).catch((err: BusinessError) => {
            console.log(`${caseName} set fail ${JSON.stringify(err)}`);
            console.info(`${caseName} catch error ${JSON.stringify(err)}`);
            expectTrue(err.code == 401);
            done();
          });
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_LOCALSOCKETSERVER_ONCONNECT_0100
     * @tc.name   : testLocalSocketServerOnConnect0100
     * @tc.desc   : test LocalSocketServer On(connect) 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketServerOnConnect0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testLocalSocketServerOnConnect0100';
        console.info(`${caseName}---Start`);
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          server.on('connect', undefined);
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_LOCALSOCKETSERVER_ONERROR_0100
     * @tc.name   : testLocalSocketServerOnError0100
     * @tc.desc   : test LocalSocketServer On(error) 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketServerOnError0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testLocalSocketServerOnError0100';
        console.info(`${caseName}---Start`);
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          server.on('error', undefined);
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_LOCALSOCKETSERVER_OFFCONNECT_0100
     * @tc.name   : testLocalSocketServerOffConnect0100
     * @tc.desc   : test LocalSocketServer Off(connect) 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketServerOffConnect0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testLocalSocketServerOffConnect0100';
        console.info(`${caseName}---Start`);
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          server.off('connect', undefined);
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_LOCALSOCKETSERVER_OFFERROR_0100
     * @tc.name   : testLocalSocketServerOffERROR0100
     * @tc.desc   : test LocalSocketServer Off(connect) 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketServerOffError0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let caseName: string = 'testLocalSocketServerOffConnect0100';
        console.info(`${caseName}---Start`);
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          server.off('error', undefined);
        } catch (err) {
          console.info(`${caseName} err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_LOCALSOCKET_CONNECT_0100
     * @tc.name   : testLocalSocketConnect0100
     * @tc.desc   : test LocalSocket Connect 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketConnect0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      let caseName: string = 'testLocalSocketConnect0100';
      console.info(`${caseName}---Start`);
      try {
        let client: socket.LocalSocket = socket.constructLocalSocketInstance();
        client.connect(undefined).then(() => {
          console.info(`${caseName} connect success`);
          done();
        }).catch((err: BusinessError) => {
          console.info(`${caseName} connect err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        });
      } catch (err) {
        console.info(`${caseName} err: ${JSON.stringify(err)}`);
        expectTrue(err.code == 401);
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number : SUB_LOCALSOCKET_SEND_0100
     * @tc.name   : testLocalSocketSend0100
     * @tc.desc   : test LocalSocket Send 401 function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testLocalSocketSend0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      let caseName: string = 'testLocalSocketSend0100';
      console.info(`${caseName}---Start`);
      try {
        let client: socket.LocalSocket = socket.constructLocalSocketInstance()
        client.send(undefined).then(() => {
          console.info(`${caseName} send success`);
          done();
        }).catch((err: BusinessError) => {
          console.info(`${caseName} send err: ${JSON.stringify(err)}`);
          expectTrue(err.code == 401);
          done();
        })
      } catch (err) {
        console.info(`${caseName} err: ${JSON.stringify(err)}`);
        expectTrue(err.code == 401);
        done();
      }
      console.info(`${caseName} test end`);
    });
  })
}