/**
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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
import {describe, it, expect} from '@ohos/hypium'
import socket from '@ohos.net.socket'
import {BusinessError} from '@ohos.base'

export default function netAddressTest() {
  describe('netAddressTest', () => {

    /**
     * @tc.number: SUB_NetworkMgr_Connection_NetAddress_0100
     * @tc.name  : testNetworkMgrConnectionNetAddress0100
     * @tc.desc  : NetAddress.address test. getDefaultNet/getConnectionProperties and all
     *             NetAddress producer APIs in ohos.net.connection are not cross-platform
     *             available, so the equivalent cross-platform path UDPSocket.bind (which
     *             consumes the same NetAddress re-exported by ohos.net.socket) is used:
     *             valid address string binds successfully with isBound true.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it('SUB_NetworkMgr_Connection_NetAddress_0100', 0, async (done: Function) => {
      let udp = socket.constructUDPSocketInstance();
      try {
        await udp.bind({ address: '127.0.0.1', port: 38888 });
        console.log('SUB_NetworkMgr_Connection_NetAddress_0100 bind 127.0.0.1 success');
        let state = await udp.getState();
        console.log('SUB_NetworkMgr_Connection_NetAddress_0100 state: ' + JSON.stringify(state));
        expect(state.isBound).assertTrue();
        await udp.close();
        done();
      } catch (error) {
        let err = error as BusinessError;
        console.error(`SUB_NetworkMgr_Connection_NetAddress_0100 failed, errCode: ${err.code}`);
        expect().assertFail();
        try {
          await udp.close();
        } catch (closeError) {
          console.error(`SUB_NetworkMgr_Connection_NetAddress_0100 close failed, errCode: ${(closeError as BusinessError).code}`);
        }
        done();
      }
    });

    /**
     * @tc.number: SUB_NetworkMgr_Connection_NetAddress_0200
     * @tc.name  : testNetworkMgrConnectionNetAddress0200
     * @tc.desc  : NetAddress.address test. Invalid address string fails to bind with
     *             error code greater than 0.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 3
     */
    it('SUB_NetworkMgr_Connection_NetAddress_0200', 3, async (done: Function) => {
      let udp = socket.constructUDPSocketInstance();
      try {
        await udp.bind({ address: 'invalid.address.value', port: 38889 });
        console.error('SUB_NetworkMgr_Connection_NetAddress_0200 invalid address bound unexpectedly');
        expect().assertFail();
        try {
          await udp.close();
        } catch (closeError) {
          console.error(`SUB_NetworkMgr_Connection_NetAddress_0200 close failed, errCode: ${(closeError as BusinessError).code}`);
        }
        done();
      } catch (error) {
        let err = error as BusinessError;
        console.info('SUB_NetworkMgr_Connection_NetAddress_0200 invalid address rejected, errCode: ' + err.code);
        expect(err.code > 0).assertTrue();
        try {
          await udp.close();
        } catch (closeError) {
          console.error(`SUB_NetworkMgr_Connection_NetAddress_0200 close failed, errCode: ${(closeError as BusinessError).code}`);
        }
        done();
      }
    });
  })
}
