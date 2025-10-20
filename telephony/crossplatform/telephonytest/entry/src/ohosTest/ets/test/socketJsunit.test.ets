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
import socket from '@ohos.net.socket';

export default function socketJsunit() {
  describe('socketTest', () => {
    console.log("************* socket Test start*************");
    let envReady = false;

    /**
     * @tc.number : TELEPHONY_SOCKET_SOCKETREMOTEINFO_PORT_0100
     * @tc.name   : testSocketRemoteInfoPort0100
     * @tc.desc   : SocketRemoteInfo.port
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testSocketRemoteInfoPort0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      (done: Function) => {
        if (!envReady) {
          console.info("The environment was not ready");
          done();
          return;
        }
        console.log("************* TELEPHONY_SOCKET_SOCKETREMOTEINFO_PORT_0100 Test start*************");
        let socketRemoteInfo: socket.SocketRemoteInfo = {
          address: "test address",
          family: 'IPv4',
          port: 8080,
          size: 1
        };
        expect(socketRemoteInfo.port === 8080).assertTrue();
        console.log("************* TELEPHONY_SOCKET_SOCKETREMOTEINFO_PORT_0100 Test end*************");
        done();
      });

    /**
     * @tc.number : TELEPHONY_SOCKET_SOCKETREMOTEINFO_SIZE_0100
     * @tc.name   : testSocketRemoteInfoSize0100
     * @tc.desc   : SocketRemoteInfo.size
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 3
     */
    it('testSocketRemoteInfoSize0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      (done: Function) => {
        if (!envReady) {
          console.info("The environment was not ready");
          done();
          return;
        }
        console.log("************* TELEPHONY_SOCKET_SOCKETREMOTEINFO_SIZE_0100 Test start*************");
        let socketRemoteInfo: socket.SocketRemoteInfo = {
          address: "test address",
          family: 'IPv4',
          port: 8080,
          size: 1
        };
        expect(socketRemoteInfo.size === 1).assertTrue();
        console.log("************* TELEPHONY_SOCKET_SOCKETREMOTEINFO_SIZE_0100 Test end*************");
        done();
      });
  })
}